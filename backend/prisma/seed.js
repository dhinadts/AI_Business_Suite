const {
  PrismaClient,
  AssociationNotificationSeverity,
  AssociationRole,
  BusinessClassification,
  BusinessType,
  UiPreset,
  UserRole,
} = require('@prisma/client');
const bcrypt = require('bcrypt');

const prisma = new PrismaClient();

const demos = [
  {
    email: 'grocery@demo.com',
    fullName: 'Grocery Demo Owner',
    company: {
      legalName: 'ABC Stores',
      tradeName: 'ABC Grocery',
      businessType: BusinessType.GROCERY,
      industry: 'Retail Grocery',
      state: 'Tamil Nadu',
      city: 'Tiruchengode',
      pincode: '637209',
      employeeCount: 3,
      monthlyRevenue: 300000,
      branchCount: 1,
      skuCount: 800,
      invoiceVolume: 300,
      hasGST: false,
      classification: BusinessClassification.NORMAL_GROCERY_STORE,
      uiPreset: UiPreset.GROCERY_SIMPLE,
    },
  },
  {
    email: 'small@demo.com',
    fullName: 'Small Business Owner',
    company: {
      legalName: 'Small Traders Pvt Ltd',
      tradeName: 'Small Traders',
      businessType: BusinessType.RETAIL,
      industry: 'Retail',
      employeeCount: 12,
      monthlyRevenue: 1800000,
      branchCount: 2,
      skuCount: 2500,
      invoiceVolume: 1500,
      hasGST: true,
      classification: BusinessClassification.SMALL_BUSINESS,
      uiPreset: UiPreset.MSME_BASIC,
    },
  },
  {
    email: 'medium@demo.com',
    fullName: 'Medium Business Owner',
    company: {
      legalName: 'Growth Distribution LLP',
      tradeName: 'Growth Distribution',
      businessType: BusinessType.DISTRIBUTION,
      industry: 'Distribution',
      employeeCount: 55,
      monthlyRevenue: 9000000,
      branchCount: 5,
      skuCount: 12000,
      invoiceVolume: 9000,
      hasGST: true,
      classification: BusinessClassification.MEDIUM_BUSINESS,
      uiPreset: UiPreset.MSME_GROWTH,
    },
  },
  {
    email: 'large@demo.com',
    fullName: 'Large Enterprise Owner',
    company: {
      legalName: 'Enterprise Manufacturing Ltd',
      tradeName: 'Enterprise Manufacturing',
      businessType: BusinessType.MANUFACTURING,
      industry: 'Manufacturing',
      employeeCount: 250,
      monthlyRevenue: 45000000,
      branchCount: 18,
      skuCount: 60000,
      invoiceVolume: 45000,
      hasGST: true,
      classification: BusinessClassification.LARGE_BUSINESS,
      uiPreset: UiPreset.ENTERPRISE_ADVANCED,
    },
  },
];

async function main() {
  const passwordHash = await bcrypt.hash('Password@123', 12);
  const seededUsers = [];
  for (const demo of demos) {
    await prisma.user.deleteMany({ where: { email: demo.email } });
    const company = await prisma.company.create({ data: demo.company });
    const user = await prisma.user.create({
      data: {
        fullName: demo.fullName,
        email: demo.email,
        phone: '9876543210',
        passwordHash,
        role: UserRole.OWNER,
        companyId: company.id,
      },
    });
    seededUsers.push({ user, company, email: demo.email });
  }

  const existingAssociation = await prisma.association.findFirst({
    where: { name: 'Tamil Nadu Retail and Transport Trade Association' },
  });
  if (existingAssociation) {
    await prisma.associationNotification.deleteMany({
      where: { associationId: existingAssociation.id },
    });
    await prisma.associationMembership.deleteMany({
      where: { associationId: existingAssociation.id },
    });
    await prisma.association.delete({ where: { id: existingAssociation.id } });
  }

  const association = await prisma.association.create({
    data: {
      name: 'Tamil Nadu Retail and Transport Trade Association',
      industry: 'Retail, Grocery, Hotel, Food Court, Transport',
      state: 'Tamil Nadu',
      district: 'Namakkal',
      description:
        'Publishes price-change advisories and operational notices for associated local businesses.',
    },
  });

  for (const item of seededUsers) {
    await prisma.associationMembership.create({
      data: {
        associationId: association.id,
        companyId: item.company.id,
        userId: item.user.id,
        role: item.email === 'grocery@demo.com' ? AssociationRole.HEAD : AssociationRole.MEMBER,
      },
    });
  }

  await prisma.associationNotification.create({
    data: {
      associationId: association.id,
      title: 'Petrol price revision advisory',
      body:
        'Fuel price movement may affect transport, delivery, and spare purchase charges. Review billing rates before closing today.',
      severity: AssociationNotificationSeverity.PRICE_CHANGE,
      actionLabel: 'Review rates',
      actionUrl: '/reports',
      sentByUserId: seededUsers[0].user.id,
      sentByRole: AssociationRole.HEAD,
      targetStates: ['Tamil Nadu'],
      targetTypes: [BusinessType.GROCERY, BusinessType.RETAIL, BusinessType.RESTAURANT],
      sentCount: seededUsers.length,
    },
  });

  console.log('Seeded demo users and association notifications');
}

main()
  .catch((error) => {
    console.error(error);
    process.exit(1);
  })
  .finally(async () => {
    await prisma.$disconnect();
  });

import { Injectable, OnModuleDestroy, OnModuleInit } from '@nestjs/common';
import { PrismaClient } from '@prisma/client';

@Injectable()
export class PrismaService extends PrismaClient implements OnModuleInit, OnModuleDestroy {
  constructor() {
    super({
      datasources: {
        db: {
          url: normalizeMongoUrl(process.env.DATABASE_URL),
        },
      },
    });
  }

  async onModuleInit() {
    await this.$connect();
  }

  async onModuleDestroy() {
    await this.$disconnect();
  }
}

export function normalizeMongoUrl(url?: string) {
  if (!url) return url;
  const trimmed = url.trim();
  const quote = trimmed.startsWith('"') || trimmed.startsWith("'") ? trimmed[0] : '';
  const unquoted = quote ? trimmed.slice(1, -1) : trimmed;
  if (!unquoted.startsWith('mongodb://') && !unquoted.startsWith('mongodb+srv://')) {
    return unquoted;
  }

  const [base, query] = unquoted.split('?', 2);
  const lastSegment = base.substring(base.lastIndexOf('/') + 1);
  if (lastSegment.trim().length > 0) return unquoted;

  return `${base.replace(/\/+$/, '')}/ai_business_suite${query ? `?${query}` : ''}`;
}

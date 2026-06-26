import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { BusinessType } from '@prisma/client';
import { IsBoolean, IsEnum, IsInt, IsNumber, IsOptional, IsString, MaxLength, Min } from 'class-validator';

export class CreateCompanyDto {
  @ApiProperty() @IsString() @MaxLength(160) legalName: string;
  @ApiPropertyOptional() @IsOptional() @IsString() @MaxLength(160) tradeName?: string;
  @ApiProperty({ enum: BusinessType }) @IsEnum(BusinessType) businessType: BusinessType;
  @ApiPropertyOptional() @IsOptional() @IsString() industry?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() gstin?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() udyamNumber?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() pan?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() state?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() city?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() address?: string;
  @ApiPropertyOptional() @IsOptional() @IsString() pincode?: string;
  @ApiProperty() @IsInt() @Min(1) employeeCount: number;
  @ApiProperty() @IsNumber() @Min(0) monthlyRevenue: number;
  @ApiProperty() @IsInt() @Min(1) branchCount: number;
  @ApiProperty() @IsInt() @Min(0) skuCount: number;
  @ApiProperty() @IsInt() @Min(0) invoiceVolume: number;
  @ApiProperty() @IsBoolean() hasGST: boolean;
}

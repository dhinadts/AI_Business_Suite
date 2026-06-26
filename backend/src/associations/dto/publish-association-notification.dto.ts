import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import {
  ArrayMaxSize,
  IsArray,
  IsEnum,
  IsOptional,
  IsString,
  IsUrl,
  MaxLength,
  MinLength,
} from 'class-validator';
import {
  AssociationNotificationSeverity,
  BusinessType,
} from '@prisma/client';

export class PublishAssociationNotificationDto {
  @ApiProperty()
  @IsString()
  @MinLength(3)
  @MaxLength(90)
  title!: string;

  @ApiProperty()
  @IsString()
  @MinLength(8)
  @MaxLength(700)
  body!: string;

  @ApiProperty({ enum: AssociationNotificationSeverity })
  @IsEnum(AssociationNotificationSeverity)
  severity!: AssociationNotificationSeverity;

  @ApiPropertyOptional()
  @IsOptional()
  @IsString()
  @MaxLength(32)
  actionLabel?: string;

  @ApiPropertyOptional()
  @IsOptional()
  @IsUrl({ require_tld: false })
  actionUrl?: string;

  @ApiPropertyOptional({ type: [String] })
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(36)
  @IsString({ each: true })
  targetStates?: string[];

  @ApiPropertyOptional({ enum: BusinessType, isArray: true })
  @IsOptional()
  @IsArray()
  @ArrayMaxSize(20)
  @IsEnum(BusinessType, { each: true })
  targetTypes?: BusinessType[];
}

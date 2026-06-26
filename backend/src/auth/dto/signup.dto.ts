import { ApiProperty, ApiPropertyOptional } from '@nestjs/swagger';
import { Type } from 'class-transformer';
import { IsEmail, IsOptional, IsPhoneNumber, IsString, MinLength, ValidateNested } from 'class-validator';

import { CreateCompanyDto } from '../../companies/dto/create-company.dto';

export class SignupDto {
  @ApiProperty() @IsString() fullName: string;
  @ApiProperty() @IsEmail() email: string;
  @ApiPropertyOptional() @IsOptional() @IsPhoneNumber('IN') phone?: string;
  @ApiProperty() @IsString() @MinLength(8) password: string;
  @ApiProperty({ type: CreateCompanyDto }) @ValidateNested() @Type(() => CreateCompanyDto) company: CreateCompanyDto;
}

import { ApiProperty } from '@nestjs/swagger';
import { IsEnum, IsString, MinLength } from 'class-validator';
import { DevicePlatform } from '@prisma/client';

export class RegisterDeviceTokenDto {
  @ApiProperty()
  @IsString()
  @MinLength(16)
  token!: string;

  @ApiProperty({ enum: DevicePlatform })
  @IsEnum(DevicePlatform)
  platform!: DevicePlatform;
}

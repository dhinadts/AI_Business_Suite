import { Controller, Get } from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';

import { PrismaService, normalizeMongoUrl } from '../prisma/prisma.service';

@ApiTags('health')
@Controller('health')
export class HealthController {
  constructor(private readonly prisma: PrismaService) {}

  @Get()
  health() {
    return {
      ok: true,
      service: 'AI Business Suite API',
      timestamp: new Date().toISOString(),
    };
  }

  @Get('db')
  async database() {
    const rawUrl = process.env.DATABASE_URL;
    const normalizedUrl = normalizeMongoUrl(rawUrl);
    const hasDatabaseUrl = Boolean(rawUrl?.trim());
    const hasDatabaseName = Boolean(
      normalizedUrl &&
        normalizedUrl
          .split('?', 2)[0]
          .substring(normalizedUrl.split('?', 2)[0].lastIndexOf('/') + 1)
          .trim(),
    );

    try {
      await this.prisma.user.count();
      return {
        ok: true,
        database: 'connected',
        hasDatabaseUrl,
        hasDatabaseName,
      };
    } catch (error) {
      return {
        ok: false,
        database: 'failed',
        hasDatabaseUrl,
        hasDatabaseName,
        error: error instanceof Error ? error.message : 'Unknown database error',
      };
    }
  }
}

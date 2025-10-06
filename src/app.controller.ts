import { Controller, Get, Post, Body } from '@nestjs/common';
import { AppService } from './app.service';

@Controller()
export class AppController {
  constructor(private readonly appService: AppService) {}

  @Get()
  getHello(): string {
    return this.appService.getHello();
  }

  @Post('items')
  createItem(@Body() body: any): any {
    // simple echo / create placeholder
    return {
      success: true,
      item: body,
      message: 'Item created',
    };
  }
}

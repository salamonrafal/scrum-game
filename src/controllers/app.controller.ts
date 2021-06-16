import { Controller, Get, Render } from "@nestjs/common";
import { AppService } from "../services/app.service";


@Controller()
export class AppController {
  constructor(
      private readonly appService: AppService
  ) {}

  @Get()
  @Render('main.hbs')
  root() {
    return { message: 'Hello world!' };
  }

  @Get("/test-ssr")
  testSSR() {
    return this.appService.getExample();
  }
}

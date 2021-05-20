import * as React from "react";
import { renderToString } from "react-dom/server";
import { Injectable, Logger } from '@nestjs/common';
import Example from "../components/example";

@Injectable()
export class AppService {
  getExample() {
      const element = React.createElement(Example, null);

      return renderToString(element);
  }
}

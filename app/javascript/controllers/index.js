import { Application } from "@hotwired/stimulus";
import ContractsController from "./contracts_controller";

const application = Application.start();
application.register("contracts", ContractsController);

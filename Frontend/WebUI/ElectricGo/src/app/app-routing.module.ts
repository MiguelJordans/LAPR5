import {RouterModule, Routes} from '@angular/router';
import {FleetManagerComponent} from './fleet-manager/fleet-manager.component';
import {LoginPageComponent} from "./components/login-page/login-page.component";
import {NgModule} from '@angular/core';
import {WarehouseManagerComponent} from './warehouse-manager/warehouse-manager.component';
import {LogManagerComponent} from "./log-manager/log-manager.component";
import {AddPackagingComponent} from './log-manager/components/add-packaging/add-packaging.component';
import {ErrorPageComponent} from "./components/error-page/error-page.component";
import {CreatePathComponent} from "./log-manager/components/create-path/create-path.component";
import { AddTruckComponent } from './fleet-manager/components/add-truck/add-truck.component';
import {AddWarehouseComponent} from "./warehouse-manager/components/add-warehouse/add-warehouse.component";
import { ListPackagingComponent } from './log-manager/components/list-packaging/list-packaging.component';

const routes: Routes = [
  {path: '', component: LoginPageComponent},

  {
    path: 'WarehouseManager',
    component: WarehouseManagerComponent
  },
  {
    path: 'WarehouseManager/addWarehouse', component: AddWarehouseComponent},
  {
    path: 'FleetManager',
    component: FleetManagerComponent
  },
  {
    path: 'FleetManager/addTruck', component: AddTruckComponent
  },
  {
    path: 'LogisticManager',
    component: LogManagerComponent
  },

  {path: 'LogisticManager/addPackaging', component: AddPackagingComponent},
  {path: 'LogisticManager/createPath', component: CreatePathComponent},
  {path: 'LogisticManager/listPackaging', component: ListPackagingComponent},
  {path: '**', component: ErrorPageComponent}
];

@NgModule({
  imports: [RouterModule.forChild(routes), RouterModule.forRoot(routes)],
  declarations: [],
  exports: [RouterModule]
})

export class AppRoutingModule {
}

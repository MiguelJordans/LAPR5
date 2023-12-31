import { HttpClient } from '@angular/common/http';
import { IPackagingDTO } from 'src/app/shared/packagingDTO';
import { Injectable } from '@angular/core';
import { AppConfigServiceService } from 'src/app/services/app-config-service.service';
import { GoogleApiCommunicationService } from 'src/app/services/google-api-communication.service';

@Injectable({
  providedIn: 'root'
})
export class ListPackagingService {

  private packaging: any;
  private packagingByParamURL: any;

  constructor(
    private http: HttpClient,
    private appConfigService: AppConfigServiceService,
    private google: GoogleApiCommunicationService
    ) {

   }

    getPackaging(): any {
      const headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'authorization' : "Bearer "+ this.google.getJWT(),
      };

      const options = {
        headers: headers
      };

      this.packaging = this.appConfigService.getLogisticsURL() + this.appConfigService.getPackagingURL();
      return this.http.get<IPackagingDTO>(this.packaging, options).toPromise();
  }

  getPackagingByTruck(truckRef: string): any {
     const headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization' : "Bearer "+ this.google.getJWT(),
    };

    const options = {
      headers: headers
    };

    this.packagingByParamURL = this.appConfigService.getLogisticsURL() + this.appConfigService.getPackagingByParamURL() + "/truck/" + truckRef;
    return this.http.get<IPackagingDTO>(this.packagingByParamURL, options).toPromise();
  }

  getPackagingByOrder(orderRef: string): any {
    const headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'authorization' : "Bearer "+ this.google.getJWT(),
    };

    const options = {
      headers: headers
    };

    this.packagingByParamURL = this.appConfigService.getLogisticsURL() + this.appConfigService.getPackagingByParamURL() + "/order/"+ orderRef;
    return this.http.get<IPackagingDTO>(this.packagingByParamURL, options).toPromise();
  }

}

import { HttpClient, HttpResponse } from '@angular/common/http';
import { Injectable } from '@angular/core';
import { ICreateOrderDTO } from '../shared/createOrderDTO';

@Injectable({
  providedIn: 'root'
})
export class CreateOrderService {
  
  constructor(private http: HttpClient) { }

  createOrder(orderDTO: ICreateOrderDTO) {
    return this.http.post<HttpResponse<any>>('https://localhost:5001/api/Order', orderDTO);
  }
}

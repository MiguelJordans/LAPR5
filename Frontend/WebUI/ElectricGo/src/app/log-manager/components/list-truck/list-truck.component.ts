import {Component, OnInit, ViewChild} from '@angular/core';
import {GetTrucksService} from '../../../services/get-trucks.service'
import {MatPaginator} from "@angular/material/paginator";
import {MatTableDataSource} from "@angular/material/table";
import {MatSort} from "@angular/material/sort";
import {ITruckDTO} from '../../../shared/truckDTO';

@Component({
  selector: 'app-list-truck',
  templateUrl: './list-truck.component.html',
  styleUrls: ['./list-truck.component.css'],
  providers: [GetTrucksService],

})
export class ListTruckComponent {

  trucks = new MatTableDataSource<ITruckDTO>();
  displayedColumns: string[] = ['Truck characteristic', 'Truck Plate', 'Weight Capacity', 'Max Weight Capacity', 'Max Battery', 'Tare', 'Charging Time'];
  // @ts-ignore
  @ViewChild(MatPaginator, {static: true}) paginator: MatPaginator ;
  // @ts-ignore
  @ViewChild(MatSort, {static: true}) sort: MatSort ;

  constructor(
    private getTrucksService: GetTrucksService
  ) { }

  ngAfterViewInit() {
    // @ts-ignore
    this.trucks.paginator = this.paginator;
  }

  ngOnInit(): void {
    this.getTrucksService.getTrucks().subscribe((trucks => {
       // @ts-ignore
       this.trucks.data = trucks;
       // @ts-ignore
       this.trucks.sort = this.sort;
       // @ts-ignore
       this.trucks.paginator = this.paginator;
    }));

  }

  goBack() {
    window.history.back();
  }


}
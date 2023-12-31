import { AggregateRoot } from "../../core/domain/AggregateRoot";
import { TripIdentifier } from "./tripIdentifier";
import { TripTruck } from "./tripTruck";
import { TripDay } from "./tripDay";
import { TripWarehouse } from "./tripWarehouses";
import { TripOrders } from "./tripOrders";
import { UniqueEntityID } from "../../core/domain/UniqueEntityID";
import { Guard } from "../../core/logic/Guard";
import { Result } from "../../core/logic/Result";
import {ICreateTripDTO} from "../../dto/trip/ICreateTripDTO";

export interface tripProps{
    tripIdentifier: TripIdentifier,
    tripTruck: TripTruck,
    tripDay: TripDay,
    tripWarehouses: TripWarehouse,
    tripOrders: TripOrders
}

export class Trip extends AggregateRoot<tripProps>{

  private constructor(props: tripProps, id: UniqueEntityID) {
    super(props, id);
  }

  get id(): UniqueEntityID {
    return this._id;
  }

  get tripOrders(): TripOrders{
    return this.props.tripOrders;
  }

  get tripIdentifier(): TripIdentifier{
    return this.props.tripIdentifier;
  }

  get tripWarehouses(): TripWarehouse{
    return this.props.tripWarehouses;
  }

  get tripTruck(): TripTruck{
    return this.props.tripTruck;
  }

  get tripDay(): TripDay{
    return this.props.tripDay;
  }

  public static create(tripProps: tripProps) : Result<Trip>{
    const guardProps = [
      {argument: tripProps.tripOrders, argumentName: 'tripOrders'},
      {argument: tripProps.tripIdentifier, argumentName: 'tripIdentifier'},
      {argument: tripProps.tripWarehouses, argumentName: 'tripWarehouses'},
      {argument: tripProps.tripTruck, argumentName: 'tripTruck'},
      {argument: tripProps.tripDay, argumentName: 'tripDay'},
    ]
    const guard =  Guard.againstNullOrUndefinedBulk(guardProps)

    if (!guard.succeeded){
      return Result.fail(guard.message)
    }

    const id =  new UniqueEntityID();

    return Result.ok(new Trip(tripProps,id));
  }

}
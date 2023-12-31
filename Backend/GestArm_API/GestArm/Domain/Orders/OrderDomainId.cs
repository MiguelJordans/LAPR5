﻿using System.Text;
using GestArm.Domain.Shared;

namespace GestArm.Domain.Orders;

public class OrderDomainId : ValueObject

{
    public OrderDomainId(string id)
    {
        _id = id;
    }

    public OrderDomainId(string number, string date)
    {
        var sb = new StringBuilder();
        sb.Append(date).Append("/").Append(number);
        _id = sb.ToString();
    }

    public string _id { get; }


    public override string ToString()
    {
        return _id;
    }


    protected override IEnumerable<object> GetEqualityComponents()
    {
        yield return _id;
    }
}
@Metadata.allowExtensions: true
@Metadata.ignorePropagatedAnnotations: true
@Endusertext: {
  Label: '###GENERATED Core Data Service Entity'
}
@Objectmodel: {
  Sapobjectnodetype.Name: 'ZBOOKINGS_01'
}
@AccessControl.authorizationCheck: #MANDATORY
define root view entity ZC_BOOKINGS_01
  provider contract TRANSACTIONAL_QUERY
  as projection on ZR_BOOKINGS_01
  association [1..1] to ZR_BOOKINGS_01 as _BaseEntity on $projection.BOOKINGID = _BaseEntity.BOOKINGID
{
  key BookingID,
  CarrierID,
  ConnectionID,
  AirportFromID,
  AirportToID,
  DistinationCity,
  StartDate,
  EndDate,
  Status,
  @Semantics: {
    Systemdatetime.Createdat: true
  }
  CreatedAt,
  @Semantics: {
    User.Createdby: true
  }
  CreatedBy,
  @Semantics: {
    Systemdatetime.Lastchangedat: true
  }
  LastChangedAt,
  @Semantics: {
    User.Lastchangedby: true
  }
  LastChangedBy,
  @Semantics: {
    Systemdatetime.Localinstancelastchangedat: true
  }
  LocalLastChangedAt,
  _BaseEntity
}

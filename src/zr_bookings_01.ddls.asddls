@AccessControl.authorizationCheck: #MANDATORY
@Metadata.allowExtensions: true
@ObjectModel.sapObjectNodeType.name: 'ZBOOKINGS_01'
@EndUserText.label: '###GENERATED Core Data Service Entity'
define root view entity ZR_BOOKINGS_01
  as select from ZBOOKINGS_01
{
  key booking_id as BookingID,
  carrier_id as CarrierID,
  connection_id as ConnectionID,
  airport_from_id as AirportFromID,
  airport_to_id as AirportToID,
  distination_city as DistinationCity,
  start_date as StartDate,
  end_date as EndDate,
  status as Status,
  @Semantics.systemDateTime.createdAt: true
  created_at as CreatedAt,
  @Semantics.user.createdBy: true
  created_by as CreatedBy,
  @Semantics.systemDateTime.lastChangedAt: true
  last_changed_at as LastChangedAt,
  @Semantics.user.lastChangedBy: true
  last_changed_by as LastChangedBy,
  @Semantics.systemDateTime.localInstanceLastChangedAt: true
  local_last_changed_at as LocalLastChangedAt
}

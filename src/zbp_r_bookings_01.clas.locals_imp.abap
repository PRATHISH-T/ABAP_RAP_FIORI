CLASS LHC_ZR_BOOKINGS_01 DEFINITION
  INHERITING FROM CL_ABAP_BEHAVIOR_HANDLER.

  PRIVATE SECTION.

    METHODS:
      GET_GLOBAL_AUTHORIZATIONS FOR GLOBAL AUTHORIZATION
        IMPORTING
          REQUEST requested_authorizations FOR ZrBookings01
        RESULT result,

      idvalidation FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrBookings01~idvalidation,

      invaliddate FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrBookings01~invaliddate,

      statusconfirmation FOR VALIDATE ON SAVE
        IMPORTING keys FOR ZrBookings01~statusconfirmation,

      satausnew FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrBookings01~satausnew,

      gettingcity FOR DETERMINE ON MODIFY
        IMPORTING keys FOR ZrBookings01~gettingcity.

ENDCLASS.



CLASS LHC_ZR_BOOKINGS_01 IMPLEMENTATION.

  METHOD GET_GLOBAL_AUTHORIZATIONS.
  ENDMETHOD.



  METHOD idvalidation.

    READ ENTITIES OF zr_bookings_01
      IN LOCAL MODE
      ENTITY ZrBookings01
      FIELDS ( AirportFromID AirportToID )
      WITH CORRESPONDING #( keys )
      RESULT DATA(user).

    LOOP AT user INTO DATA(wa).

      SELECT SINGLE *
        FROM /dmo/connection
        WHERE airport_from_id = @wa-AirportFromID
          AND airport_to_id   = @wa-AirportToID
        INTO @DATA(st).

      IF sy-subrc <> 0.

        APPEND VALUE #( %tky = wa-%tky )
          TO failed-zrbookings01.

        APPEND VALUE #(
          %tky = wa-%tky
          %msg = NEW_MESSAGE_WITH_TEXT(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'the entered from and to airport must be valid'
                 )
        ) TO reported-zrbookings01.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.



  METHOD invaliddate.

    READ ENTITIES OF zr_bookings_01
      IN LOCAL MODE
      ENTITY ZrBookings01
      FIELDS ( EndDate StartDate )
      WITH CORRESPONDING #( keys )
      RESULT DATA(user).

    LOOP AT user INTO DATA(wa).

      IF wa-EndDate <= wa-StartDate.

        APPEND VALUE #( %tky = wa-%tky )
          TO failed-zrbookings01.

        APPEND VALUE #(
          %tky = wa-%tky
          %msg = NEW_MESSAGE_WITH_TEXT(
                   severity = if_abap_behv_message=>severity-error
                   text     = 'Entered end date is equal or less than start date'
                 )
        ) TO reported-zrbookings01.

      ENDIF.

    ENDLOOP.

  ENDMETHOD.



  METHOD statusconfirmation.
reAD eNTITIES OF zr_bookings_01
in LOCAL MODE
enTITY ZrBookings01
all fIELDS
wITH corRESPONDING #( keys )
result data(user).



loop at user into data(wa).

loop AT keys into data(k).

select sINGLE status
from zr_bookings_01
where   BookingID = @k-BookingID
into @data(old).



  IF to_upper( old ) = 'CONFIRMED'.
   APPEND VALUE #( %tky = wa-%tky )
        TO failed-zrbookings01.
append value #(
 %tky = wa-%tky
 ) to failed-zrbookings01.
      APPEND VALUE #(
        %tky = wa-%tky
        %msg = NEW_MESSAGE_WITH_TEXT(
                 severity = if_abap_behv_message=>severity-error
                 text     = 'You have confirmed so no changes can be made'
               )
      ) TO reported-zrbookings01.
      endif.

endloop.



endloop.



  ENDMETHOD.



  METHOD  satausnew.
 read ENTITIES OF zr_bookings_01
 in LOCAL MODE
 enTITY ZrBookings01
 fIELDS ( Status )
 with correSPONDING #( keys )
 result data(user).

 moDIFY eNTITIES OF zr_bookings_01
 in LOCAL MODE
 enTITY ZrBookings01
 upDATE fIELDS ( Status )
 with value #(
 for us in user
 let val = 'NEW'
 IN
 ( %tky = us-%tky
 Status = val
  )
  ).


ENDMETHOD.

METHOD gettingcity.

  DATA: lt_update TYPE TABLE FOR UPDATE zr_bookings_01.

  READ ENTITIES OF zr_bookings_01
    IN LOCAL MODE
    ENTITY ZrBookings01
    FIELDS ( AirportToID DistinationCity )
    WITH CORRESPONDING #( keys )
    RESULT DATA(user).


  select * from /dmo/airport
  for ALL ENTRIES IN @user
  where airport_id = @user-AirportToID
  into table @data(tb).

  modIFY eNTITIES OF zr_bookings_01
  in LOCAL MODE
  enTITY ZrBookings01
  upDATE fIELDS ( DistinationCity )
  with value #(
  for us in user
  let val = value #( tb[ airport_id = us-AirportToID ] optional )
  in
  (
  %tky = us-%tky
  DistinationCity = val
  )
  ).

ENDMETHOD.


ENDCLASS.

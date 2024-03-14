namespace anjani.db;
type guid : String(32);
using { managed,cuid } from '@sap/cds/common';
using { anjani.common } from './common.cds';


context master{
    entity businesspartner {
       key NODE_KEY: guid;
        BP_ROLE: String(2);
        EMAIL_ADDRESS: String(64);
        PHONE_NUMBER: String(14);
        FAX_NUMBER: String(14);
        WEB_ADDRESS: String(64);
        ADDRESS_GUID: String(32);
        BP_ID: String(16);
        COMPANY_NAME:String(80);        
    }
    entity address {
        key NODE_KEY: guid;
        CITY:String(64);
        POSTAL_CODE:String(14);
        STREET:String(64);
        BUILDING:String(64);
        COUNTRY:String(2);
        VAL_START_DATE:Date;
        VAL_END_DATE:Date;
        LATITUDE:Decimal;
        LONGITUDE:Decimal;
       // businesspartner: Association to one businesspartner
      //  on businesspartner.ADDRESS_GUID = $self;
    }   
    
        entity prodtext{
            key NODE_KEY: guid;
            PARENT_KEY: guid;
            LANGUAGE: String(2);
            TEXT: String(256);
        }

        entity product{
            key NODE_KEY: guid;
            PRODUCT_ID: String(28);
            TYPE_CODE:String(2);
            CATEGORY:String(32);
            DECS_GUID: Association to prodtext;
            SUPPLIER_GUID: Association to master.businesspartner;
            TAX_TARIF_CODE: Integer;
            MEASURE_UNIT: String(2);
            WEIGHT_MEASURE: Decimal;
            WEIGHT_UNIT: String(2);
            CURRENCY_CODE:String(4);
            PRICE: Decimal;
            WIDTH: Decimal;
            DEPTH:Decimal;
            HEIGHT: Decimal;
            DIM_UNIT: String(2);
        }

        entity employee:cuid, managed{
            nameFirst:String(40);
            nameMiddle:String(40);
            nameLast:String(40);
            nameInitials:String(40);
            sex: common.Gender;
            language: String(1);
            phoneNumber:common.PhoneNumber;
            email:common.Email;
            loginName:String(12);
           // currency_code:Currency;
            salaryAmount:common.AmountT;
            accountNumber:String(16);
            bankId:String(8);
            bankName:String(64);

        }     
    
}
context transaction{
    entity purchaseorder:common.Amount{
        key NODE_KEY: guid;
        PO_ID: String(24);
        PARTNER_GUID: association to master.businesspartner;      
        LIFECYCLE_STATUS: String(1);
        OVERALL_STATUS: String(1);
        Items: Association to many poitems on Items.PARENT_KEY = $self;
    }
    entity poitems: common.Amount{
        key NODE_KEY: guid;
        PARENT_KEY: Association to purchaseorder;
        PO_ITEM_POS: Integer;
        PRODUCT_GUID: Association to master.product;
    }
}


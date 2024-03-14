namespace anjani.common;
using { sap,Currency,temporal,managed  } from '@sap/cds/common';

type Gender : String(1) enum{
    male = 'M';
    female = 'F';
    nonBinary = 'N';
    noDisclouser = 'D';
    selDescribe = 'S';
};
type AmountT : Decimal(15,2)@(
    Semantics.amount.currencyCode: 'CURRENCY_CODE',
    sap.unit: 'CURRENCY_CODE'
);

abstract entity Amount {
      CURRENCY_CODE: String(4);
        GROSS_AMOUNT: AmountT;
        NET_AMOUNT: AmountT;
        TAX_AMOUNT: AmountT;
    
}
type PhoneNumber : String(30)@assert.format:'^(\+\d{1,3}[- ]?)?\d{10}$';
type Email : String(255)@assert.format:'[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}';






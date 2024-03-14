namespace anjani.db;
using {anjani.db.master,anjani.db.transaction} from './datamodel';
context CDSViews {
    define view![POWorklist] as 
    select from transaction.purchaseorder{
        key PO_ID as![PurchaseOrderId],
            PARTNER_GUID.BP_ID as![PartnerId],
            PARTNER_GUID.COMPANY_NAME as![CompanyName],
            GROSS_AMOUNT as![POGrossAmount],
            CURRENCY_CODE as![POCurrencyCode],
            LIFECYCLE_STATUS as![POStatus],
        key Items.PO_ITEM_POS as![ItemPosition],
            Items.PRODUCT_GUID.PRODUCT_ID as![ProductId],
            Items.PRODUCT_GUID.DECS_GUID as![ProductName],
            Items.GROSS_AMOUNT as![GrossAmount],
            Items.NET_AMOUNT as![NetAmount],
            Items.CURRENCY_CODE as![CurrencyCode]

    };
};

        define view ProductValueHelp as
        select from master.product{
            @EndUserText.lable:[
                {
                  language:'EN',
                  text:'Product Id'
                },{
                    language:'DE',
                  text:'Prodekt Id'
                }
            ]
            PRODUCT_ID as ![ProductId],
             @EndUserText.lable:[
                {

                  language:'EN',
                  text:'Product Description'
                },{
                    language:'DE',
                  text:'Prodekt Description'
                }
            ]
            DECS_GUID as ![Description],
        };
         

    define view![ItemView] as
    select from transaction.poitems{
        PARENT_KEY.PARTNER_GUID.NODE_KEY as![Partner],
        PRODUCT_GUID.NODE_KEY as![ProductId],
        CURRENCY_CODE as![CurrencyCode],
        GROSS_AMOUNT as![GrossAmount],
        NET_AMOUNT as![NetAmount],
        TAX_AMOUNT as![TaxAmount],
        PARENT_KEY.OVERALL_STATUS as![POStatus]

    };
define view![ProductViewSub] as 
select from master.product as prod{
    PRODUCT_ID as![ProductId],
    DECS_GUID as![ProductDescription],
    (
        select from transaction.poitems as a{
                   sum(a.GROSS_AMOUNT) as SUM
        }
        where a.NODE_KEY = prod.NODE_KEY        
    )as PO_SUM
};
define view ProductView as 
select from master.product 
mixin{
    PO_ORDERS:Association[*] to ItemView
    on PO_ORDERS.ProductId = $projection.ProductId
}
into{
    NODE_KEY as![ProductId],
    CATEGORY as![category],
    PRICE as![Price],
    TYPE_CODE as![TypeCode],
    SUPPLIER_GUID.BP_ID as![BPId],
    SUPPLIER_GUID.COMPANY_NAME as![CompanyName],
    //Exposed Association, which means when someone read the view
    //the data for orders wont be read by default
    //untill unless someone consume the association
    PO_ORDERS
};
define view CProductValuesView as 
select from ProductView{
    ProductId,
    PO_ORDERS.CurrencyCode as![CurrencyCode],
    sum(PO_ORDERS.GrossAmount) as![POGrossAmount]
}
group by ProductId,PO_ORDERS.CurrencyCode;

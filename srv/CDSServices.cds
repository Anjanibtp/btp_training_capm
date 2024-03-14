
using {anjani.db.CDSViews } from '../db/CDSViews';
using {anjani.db.master,anjani.db.transaction} from '../db/datamodel';

service CDSService@(path:'/CDSService') {
    entity POWorklist as projection on CDSViews.POWorklist;
    // entity ProductOrders as projection on CDSViews.ProductViewSub;
    // entity ProductAggregation as projection on CDSViews.CProductValuesView;


    }



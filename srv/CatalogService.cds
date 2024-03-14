using { anjani.db.master, anjani.db.transaction } from '../db/datamodel';

service CatalogService@(path:'/CatalogService') {
entity EmployeeSet as projection on master.employee;
entity AddressSet as projection on master.address;
entity ProductSet as projection on master.product; 
entity ProductTexts as projection on master.prodtext;  
entity BPSet as projection on master.businesspartner;
}
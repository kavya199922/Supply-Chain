pragma solidity ^0.4.25;

contract SupplyChain{
  
 
    uint pku=0;
    enum Status{ OrderCreated,Distribution,ShippingStarts,ShippingEnds,Pharmacy
}
modifier onlyDistributor(uint _pku){
    bool exists=false;
   
    for(uint i=0;i<track[_pku].Distributor.length;i++){
        if(track[_pku].Distributor[i]==msg.sender){
            exists=true;
            break;
        }
    }
    require(exists==true);
    _;
}
modifier onlyPharmacy(uint _pku){
    require(track[_pku].Pharmacy==msg.sender);
    _;
}
modifier onlyShippingCompany(uint _pku){
    require(track[_pku].ShippingCompany==msg.sender);
    _;
}
struct Order{
    //orderid
    string DrugName;
    uint256 DrugID;
    address Manufacturer;
    address ShippingCompany;
    address[] Distributor;//array of distributors
    address Pharmacy;
   // address Customer;
    Status status;
}
mapping(uint=>Order) track;
Order[]   orders;

function getOrders(uint256 _pku) public view returns(string,uint256,address,address,address[],address,Status){
    Order memory order=track[_pku];
    return(order.DrugName,order.DrugID,order.Manufacturer,order.ShippingCompany,order.Distributor,order.Pharmacy,order.status);
}
function CreateOrder(string _drugname,uint256 _drugid,address _ShippingCompany,address _distributor) public  {
   
            
         //  track[++pku]=Order(_drugname,_drugid,msg.sender,_ShippingCompany,_distributor,0x0,Status.OrderCreated);
            //   Order memory order;
            //   order.DrugName=_drugname;
            //   order.DrugID=_drugid;
            //   order.Manufacturer=msg.sender;
            //   order.ShippingCompany=_ShippingCompany;
            //   order.Pharmacy=0x0;
            //   order.status=Status.OrderCreated;
            //   orders.push(order);
            //   orders[orders.length-1].Distributor.push(_distributor);
            //   track[++pku]=order;
            track[++pku].DrugName=_drugname;
            track[pku].DrugID=_drugid;
            track[pku].Manufacturer=msg.sender;
            track[pku].ShippingCompany=_ShippingCompany;
            track[pku].Pharmacy=0x0;
            track[pku].status=Status.OrderCreated;
            track[pku].Distributor.push(_distributor);
}


function addDistributor(address _distributor,uint _pku) public onlyDistributor(_pku){
    
     track[_pku].status=Status.Distribution;
     track[_pku].Distributor.push(_distributor);
}
function addPharmacy(address _Pharmacy,uint _pku) public onlyDistributor(_pku){
    
     track[_pku].Pharmacy=_Pharmacy;
     track[_pku].status=Status.Distribution;
     
     
}

function PharmacyUpdateOrder(uint _pku) public onlyPharmacy(_pku){
     
track[_pku].status=Status.Pharmacy; 
}

function ShippingStarts(uint _pku) public onlyShippingCompany(_pku){

track[_pku].status=Status.ShippingStarts;
}
function ShippingEnds(uint _pku) public onlyShippingCompany(_pku){

track[_pku].status=Status.ShippingEnds;
}

}
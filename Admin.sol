pragma solidity ^0.4.25;
pragma experimental ABIEncoderV2;
contract Admin{
    address internal admin;
    constructor () public{
        admin=msg.sender;
    }
    //onlyAdmin
    modifier onlyAdmin(){
        require(msg.sender==admin);
        _;
    }
    //user address->type mapping
    mapping(address => string) internal users;
    address[] internal UserAddress;
    string[] internal Usertype;
//Add users
    function add(address _key, string _value)  public onlyAdmin {

        users[_key] = _value;
        UserAddress.push(_key);
        Usertype.push(_value);
    }
//get type of user
    function usertype(address _key) onlyAdmin public view returns (string) {
    
        return users[_key];
    }
//No.of Users
    function size() public onlyAdmin view returns (uint)  {
       
        return uint(UserAddress.length);
    }
////Get Address alone   
    function getKeys() public onlyAdmin view returns (address[]) {
          
        return UserAddress;
    }
    ///Get Type Alone
     function getType() public onlyAdmin view returns (string[]) {
          
        return Usertype;
    }
    
  
   
}


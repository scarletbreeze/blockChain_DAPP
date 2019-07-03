pragma solidity ^0.4.23;

contract RealEstate {
    struct Buyer { // 매입자 정보
        address buyerAddress;
        bytes32 name;
        uint age;
    }

    mapping (uint => Buyer) public buyerInfo; // 매물의 아이디를 키값으로 하면 매입자의 정보를 불러오는 구조
    address public owner;
    address[10] public buyers; // 매물이 10개 있으니까 10명만 살 수 있도록 고정시킴

    event LogBuyRealEstate(
        address _buyer,
        uint _id
    );

    constructor() public {
        owner = msg.sender;
    }
    //payable: 함수가 이더를 받아야 할 떄, 즉 매입자가 매입을 했을 때, 메타마스크가 뜨고, 이더를 이 함술 보낸다.
    function buyRealEstate(uint _id, bytes32 _name, uint _age) public payable {
        require(_id >= 0 && _id <= 9); // 유효성 체크
        buyers[_id] = msg.sender; // 매물을 구입하고 있는 현재 계정을 배열에 저장
        buyerInfo[_id] = Buyer(msg.sender, _name, _age);

        owner.transfer(msg.value);  // 이더를 계정에서 계정으로 이동할 때, tranfer 함수를 쓰고,
        //msg.value는 이 함수로 넘어온 이더를 뜻함, msg.value는 way만 취급
        emit LogBuyRealEstate(msg.sender, _id);
    }

    function getBuyerInfo(uint _id) public view returns (address, bytes32, uint){
        Buyer memory buyer = buyerInfo[_id];
        return (buyer.buyerAddress, buyer.name, buyer.age);
    }

    function getAllBuyers() public view returns (address[10]){
        return buyers;
    }
}

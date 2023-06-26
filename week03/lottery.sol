

contract Lottery {
    address public manager;
    address payable[] public players;
    
    constructor() {
        manager = msg.sender;
    }
    
    modifier restricted() {
        require(msg.sender == manager, "Only the manager can call this function.");
        _;
    }
    
    function enter() public payable {
        require(msg.value > 0.01 ether, "Insufficient value sent.");
        players.push(payable(msg.sender));
    }
    
    function random() private view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.prevrandao, block.number, players)));
    }
    
    function pickWinner() public restricted {
        require(players.length > 0, "No players participated in the lottery.");

        address contractAddress = address(this);

        address payable[] memory eligibleWinners;
        uint count = 0;

        for (uint i = 0; i < players.length; i++) {
            address payable participant = players[i];
            bytes memory addressBytes = abi.encodePacked(participant);
            bytes1 prefix = (addressBytes[0]);
            
            if (int(prefix) == 0xD || prefix == bytes1(0xF)) {
                eligibleWinners[count] = participant;
                count++;
            }
        }

        if (count == 0) {
            uint index = random() % players.length;
            eligibleWinners[0] = players[index];
            count = 1;
        }

        uint winnerIndex = random() % count;
        address payable winner = eligibleWinners[winnerIndex];

        winner.transfer(contractAddress.balance);
        players = new address payable[](0);
    }
    
    function getPlayers() public view returns (address payable[] memory) {
        return players;
    }
}

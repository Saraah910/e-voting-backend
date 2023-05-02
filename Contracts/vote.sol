//SPDX-License-Identifier:MIT
pragma solidity ^0.8.8;
import "./minmax.sol";

error vote__NonIndianError();
error vote__voteGivenAlready();
error vote__wrongWardNumberError();
error vote__VoterDetailsNotAddedError();
error vote__noReleventDataFoundError();
error vote__ZeroVotedError();
error vote__AlreadyVoteGivenError();
error vote__UnderagedVoterError();
error vote__NotElectionCommissonerError();
error vote__GoforLotteryError();

contract vote {
    using minmax for uint256;
    //1.Entre details ✅
    //2.give vote ✅
    //3.approve vote ✅
    //4.store in the data structure ✅
    //5.show statistics of the election✅
    //6.in case of similar votes go for a lottery

    struct VoterDetails{
        string Name;
        uint16 Age;
        string Nationality;
        uint256 Aadhar;
        string Pan;
        uint16 Ward;
        bool voteGivenOrNot;
    }

    uint256 Amit_Shah = 0;
    uint256 Rahul_Gandhi = 0;
    uint256 Mamata_Banargee = 0;
    uint256 Kejariwal = 0;
    string Winner;

    address private immutable i_owner;
    mapping(address => VoterDetails) private s_voterDetails;
    mapping(string => uint256) private s_voteToCandidate;
    mapping(address => bool) private userExists;
    address[] public s_totalVoters;
    uint256 totalVotedCount = 0;
    uint256 candidatesWithSimilarVote = 0; 
    string [4] private candidates = ["Amit shah","Rahul gandhi","Mamata banargee","Arvind Kejariwal"];
    string[] private similarVoteCount;

    event VoterDetailsAdded(
        address indexed voterAddress,
        uint256 indexed AadharNumber,
        string indexed PanNumber
    );

    event detailsUpdated(
        address indexed voterAddress
    );

    modifier CheckAge(uint16 age){
        if(age < 18){
            revert vote__UnderagedVoterError();
        }
        _;
        
    }

    modifier AlreadyVoteGiven(address voter){
        if(s_voterDetails[voter].voteGivenOrNot == true){
            revert vote__AlreadyVoteGivenError();
        }
        _;
        
    }

    modifier _exists(address voter){
        if(!userExists[voter]){
            revert vote__VoterDetailsNotAddedError();
        }
        _;
        
    }

    modifier OnlyElectionCommissioner(){
        if(msg.sender != i_owner){
            revert vote__NotElectionCommissonerError();
        }
        _;
    }

    modifier _CheckVotedCount(){
        if(totalVotedCount <= 0){
            revert vote__ZeroVotedError();
        } 
        _;
        
    }

    constructor(address ElectionCommissioner){
        i_owner = ElectionCommissioner;
    }

    function EntreDetails(
        string memory name, 
        uint16 age,
        string memory nationality,
        uint256 aadhar,
        string memory pan,
        uint16 ward_no
        
        ) external CheckAge(age){

        VoterDetails memory newVoter = VoterDetails({
            Name: name,
            Age: age,
            Nationality: nationality,
            Aadhar: aadhar,
            Pan: pan,
            Ward: ward_no,
            voteGivenOrNot: false
        });
        s_voterDetails[msg.sender] = newVoter;
        s_totalVoters.push(msg.sender);
        userExists[msg.sender] = true;
        emit VoterDetailsAdded(msg.sender,aadhar,pan);
        
    }

    function updateDetails(
        address voterAddress,
        string memory name, 
        uint16 age,
        string memory nationality,
        uint256 aadhar,
        string memory pan,
        uint16 ward_no
        ) external CheckAge(age) _exists(msg.sender){

        delete s_voterDetails[voterAddress];

        VoterDetails memory newlyVoter = VoterDetails({
            Name: name,
            Age: age,
            Nationality: nationality,
            Aadhar: aadhar,
            Pan: pan,
            Ward: ward_no,
            voteGivenOrNot: false
        });
        s_voterDetails[voterAddress] = newlyVoter;
        s_totalVoters.push(voterAddress);

        emit detailsUpdated(msg.sender);
    }

    function giveVote(address voter, string memory candidate)external AlreadyVoteGiven(voter) _exists(voter){
        //select the candidate from the given suggested names.
        //e.g 1. Amit Shah 2. Rahhul Gandhi 3. Mamata Banargee 4. Arvind Kejariwal
        s_voteToCandidate[candidate] += 1;
        
    }
    function approveVote(address voter, uint256 aadhar)external{
        VoterDetails memory vd2 = s_voterDetails[voter];

        if(vd2.Aadhar != aadhar){
            revert vote__noReleventDataFoundError();
        }

        if(vd2.voteGivenOrNot){
            revert vote__voteGivenAlready();
        }
        
        if(vd2.Ward > 200 && vd2.Ward < 100){
            revert vote__wrongWardNumberError();
        }

        vd2.voteGivenOrNot = true;
        delete s_voterDetails[msg.sender];
        s_voterDetails[msg.sender] = vd2;
        totalVotedCount ++;

    }

    // function TotalVoterAddresses() external view returns(address[] memory){
    //     return s_totalVoters;
    // }

    function CandidateLottery() external pure returns(string memory){
        return "go for lottery";
    }

    function CalculateWinnerCandidate() external OnlyElectionCommissioner() _CheckVotedCount() {

        for(uint16 i=0; i<s_totalVoters.length; i++){
            address voter1 = s_totalVoters[i];
            if(s_voterDetails[voter1].voteGivenOrNot){
                Amit_Shah = s_voteToCandidate[candidates[0]];
                Rahul_Gandhi = s_voteToCandidate[candidates[1]];
                Mamata_Banargee = s_voteToCandidate[candidates[2]];
                Kejariwal = s_voteToCandidate[candidates[3]];
            }
        }

        uint256 MaximumVoteofBallot = minmax.findMax(Amit_Shah, Rahul_Gandhi, Mamata_Banargee, Kejariwal);
        
        for(uint16 i = 0; i<4; i++){
            if(s_voteToCandidate[candidates[i]] == MaximumVoteofBallot ){
                Winner = candidates[i];
            }
        }

    }


    //All view or pure functions

    function showTotalVotedCount() external view returns(uint256){
        return totalVotedCount;
    }

    function showMyDetails(address voter) _exists(voter) external view returns(VoterDetails memory){
        VoterDetails memory myDetails = s_voterDetails[voter];
        return myDetails;
    }

    function totalNonVotedCount() external view returns(uint256){
        uint256 nonVotedVoters = s_totalVoters.length - totalVotedCount;
        return nonVotedVoters;
    }

    function showWinner() _CheckVotedCount() external view returns(string memory){
        return Winner;
    }
}
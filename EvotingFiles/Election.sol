pragma solidity ^0.4.24;

contract Election{

	//MODEL  a candidate
	struct Candidate {
		uint id;
		string name;
		uint voteCount;
	}

	// store candidates. mapping is a hash array where we associate a key-value pairs. like a dict
	// key is a uint, later corresponding to the candidate id
	// what we store (the value) is a Candidate
	mapping(uint => Candidate) public candidates; // public, so that w can access with a free function 



	//store accounts that have voted. quick lookup of addresses that have voted or not
	mapping(address => bool) public voters; // public, so that w can access with a free function     
	
	//store candidate count
	// since mappings cant be looped and is difficult the have a count like array
	// we need a var to store the coutings  
	uint public candidatesCount;
	// useful also to iterate the mapping 




	// event, voted event. this will trigger when we want
	//  when a vote is cast for example, in the vote function. 
	//
	event votedEvent (
		uint indexed _candidateId
	);

	function Election () public {
	 addCandidate("Candidate 1");
	 addCandidate("Candidate 2");
	}

    // add candidate local variable (_var).   private because we dont want to be accesible or add candidate to our mapping. We only want
    // our contract to be able to do that, from constructor
    function addCandidate (string _name) private {
    	candidatesCount ++; // inc count at the begining. represents ID also. 
    	candidates[candidatesCount] = Candidate(candidatesCount, _name,0);
    	// reference the mapping with the key (that is the count). We assign the value to 
    	// the mapping, the count will be the ID.  Initial value of 0 for votecount, evident. 
    }


    function vote (uint _candidateId) public {
    		// we call this func as (generate an instance named app before) 
    		// app.vote{1, {from:web.eth.accounts[0]} so the 2nd
    		// argument is a metadata. it gets the account 0 from the list of ganache cli
    		//it will generate a transaction receipt, since we write in the BC



    		// require that they have not voted before
    		require(!voters[msg.sender]);  
    		// if the condition is ok the rest of code will be executed, otherwise stops exec
   

    		// require valid candidate
    		require(_candidateId > 0 && _candidateId <= candidatesCount); 
    		// value greater than 0 and less or equal than candidates count
    		// try to be concrete here, to avoid bugs

    	   // record that voter has voted to avoid multiple voting
    	   // msg.sender is metadata that is always passed internally. this is who executes/calls the function
    	     voters[msg.sender] = true;  // this addres has voted

           // increase the vot count of the candidate 
           candidates[_candidateId].voteCount ++;  // retrieve from mapping using the key Id candidate

           //trigger voted event. use emit reserved word. 
           emit votedEvent(_candidateId);
    }
}
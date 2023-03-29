// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract crowdfunding {
    struct Campaign{
        address owner;
        string title;
        string description;
        uint target;
        uint amountcollected;
        uint deadline;
        string image;
        address[] donators;
        uint[] donations;
    }

    mapping (uint => Campaign) public campaigns;

    uint public numberofcampaigns = 0;

    function createcampaign(
        string memory _title,
         string memory _description,
        address _owner,uint _target,
        uint _amountcollected,
        uint _deadline,
        string memory _image
    ) public returns (uint){
        Campaign storage campaign = campaigns[numberofcampaigns];
        require(campaign.deadline > block.timestamp,
        "deadline must be in future"
        );

        campaign.owner = _owner;
        campaign.title = _title;
        campaign.description = _description;
        campaign.amountcollected = _amountcollected;
        campaign.target = _target;
        campaign.deadline = _deadline;
        campaign.image = _image;

        numberofcampaigns++;

        return (numberofcampaigns -1);

    }

    function donatecampaign(uint _id) public payable {
        uint amount = msg.value; //amount sending by donator
        Campaign storage campaign = campaigns[_id];
        campaign.donators.push(msg.sender);
        campaign.donations.push(amount);

        (bool sent, ) = payable(campaign.owner).call{value:amount}("");
        if (sent) {
            campaign.amountcollected = campaign.amountcollected + amount;
        }        
    }

    function getdonators(uint _id) public view returns(address[] memory , uint[] memory){
        return(campaigns[_id].donators,campaigns[_id].donations);
    }

    function getcampaigns() public view returns(Campaign[] memory) {
        Campaign[] memory allcampaigns = new Campaign[](numberofcampaigns);
        for (uint i=0; i< numberofcampaigns ; i++)
        {
            Campaign storage item = campaigns[i];
            allcampaigns[i] = item;

        } 
        return allcampaigns;
    }

}
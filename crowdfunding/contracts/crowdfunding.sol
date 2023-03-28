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

    function createcampaign(string memory _title, string memory _description, address _owner,uint _target, uint _amountcollected, uint _deadline, string memory _image) public returns (uint){
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

    function donatecampaign() public {}

    function getdonators() public {}

    function getcampaigns() public {}

}
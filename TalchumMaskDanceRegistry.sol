// SPDX-License-Identifier: MIT
pragma solidity 0.8.31;

contract TalchumMaskDanceRegistry {

    struct TalchumTradition {
        string maskName;            // Hahoe Yangban, Bongsan Monk, etc.
        string region;              // Hahoe, Bongsan, Yangju
        string materials;           // alder wood, lacquer, natural pigments
        string danceStyle;          // slow steps, jumps, circular motions
        string musicalEnsemble;     // pungmul, samulnori, drums, flutes
        string culturalContext;     // satire, rituals, festivals
        string uniqueness;          // UNESCO status, regional identity
        address creator;
        uint256 likes;
        uint256 dislikes;
        uint256 createdAt;
    }

    struct TalchumInput {
        string maskName;
        string region;
        string materials;
        string danceStyle;
        string musicalEnsemble;
        string culturalContext;
        string uniqueness;
    }

    TalchumTradition[] public traditions;
    mapping(uint256 => mapping(address => bool)) public hasVoted;

    event TalchumRecorded(uint256 indexed id, string maskName, address indexed creator);
    event TalchumVoted(uint256 indexed id, bool like, uint256 likes, uint256 dislikes);

    constructor() {
        traditions.push(
            TalchumTradition({
                maskName: "Example (replace manually)",
                region: "example",
                materials: "example",
                danceStyle: "example",
                musicalEnsemble: "example",
                culturalContext: "example",
                uniqueness: "example",
                creator: address(0),
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );
    }

    function recordTalchum(TalchumInput calldata t) external {
        traditions.push(
            TalchumTradition({
                maskName: t.maskName,
                region: t.region,
                materials: t.materials,
                danceStyle: t.danceStyle,
                musicalEnsemble: t.musicalEnsemble,
                culturalContext: t.culturalContext,
                uniqueness: t.uniqueness,
                creator: msg.sender,
                likes: 0,
                dislikes: 0,
                createdAt: block.timestamp
            })
        );

        emit TalchumRecorded(traditions.length - 1, t.maskName, msg.sender);
    }

    function voteTalchum(uint256 id, bool like) external {
        require(id < traditions.length, "Invalid ID");
        require(!hasVoted[id][msg.sender], "Already voted");

        hasVoted[id][msg.sender] = true;
        TalchumTradition storage t = traditions[id];

        if (like) t.likes++;
        else t.dislikes++;

        emit TalchumVoted(id, like, t.likes, t.dislikes);
    }

    function totalTalchum() external view returns (uint256) {
        return traditions.length;
    }
}

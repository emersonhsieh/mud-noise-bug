// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;
import { System, IWorld } from "solecs/System.sol";
import { getAddressById } from "solecs/utils.sol";
import { CounterComponent, ID as CounterComponentID } from "components/CounterComponent.sol";
import { LibMath } from "libraries/LibMath.sol";
import { Perlin } from "noise/Perlin.sol";

uint256 constant ID = uint256(keccak256("system.Increment"));

contract IncrementSystem is System {
  constructor(IWorld _world, address _components) System(_world, _components) {}

  function execute(bytes memory arguments) public returns (bytes memory) {
    uint256 entity = abi.decode(arguments, (uint256));
    CounterComponent c = CounterComponent(getAddressById(components, CounterComponentID));

    // // test calling perlin
    // int128 a = Perlin.noise2d(0, 0, 0, 0);

    // // test calling a public function, causes error
    LibMath.testPublic();

    LibMath.increment(c, entity);
  }

  function executeTyped(uint256 entity) public returns (bytes memory) {
    return execute(abi.encode(entity));
  }
}

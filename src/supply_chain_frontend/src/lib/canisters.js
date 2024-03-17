import { createActor, canisterId } from 'declarations/supply_chain/supplier';
import { createActor, canisterId } from 'declarations/supply_chain/manufacturer';
import { createActor, canisterId } from 'declarations/supply_chain/distributor';
import { createActor, canisterId } from 'declarations/supply_chain/retailer'; 
import { building } from '$app/environment';

function dummyActor() {
    return new Proxy({}, { get() { throw new Error("Canister invoked while building"); } });
}

const buildingOrTesting = building || process.env.NODE_ENV === "test";

export const backend = buildingOrTesting
  ? dummyActor()
  : createActor(canisterId);

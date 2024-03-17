import { createActor as createSupplierActor, canisterId as supplierCanisterId } from 'declarations/supply_chain/supplier';
import { createActor as createManufacturerActor, canisterId as manufacturerCanisterId } from 'declarations/supply_chain/manufacturer';
import { createActor as createDistributorActor, canisterId as distributorCanisterId } from 'declarations/supply_chain/distributor';
import { createActor as createRetailerActor, canisterId as retailerCanisterId } from 'declarations/supply_chain/retailer';

import { building } from '$app/environment';

const buildingOrTesting = building || process.env.NODE_ENV === "test";

export const supplier = buildingOrTesting
  ? dummyActor()
  : createSupplierActor(supplierCanisterId);

export const manufacturer = buildingOrTesting
  ? dummyActor()
  : createManufacturerActor(manufacturerCanisterId);

export const distributor = buildingOrTesting
  ? dummyActor()
  : createDistributorActor(distributorCanisterId);

export const retailer = buildingOrTesting
  ? dummyActor()
  : createRetailerActor(retailerCanisterId);


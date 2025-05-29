import { users, login, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Cross-domain evaluation 2025";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css12_ceonadmin;
    login(user.idp, user.email, user.password);
    openGroup("Cross-domain evaluation 2025");

    simpleTest("All accessible data", 2733);
    variablesTest("Product details", { ProductLabel: '"Acoustic layer"' }, 39);
    variablesTest("Product Components", { ProductLabel: '"Nortec"' }, 3);
    variablesTest("Product Matter Composition", { ProductLabel: '"Sportflex-Eco"' }, 3);
    variablesTest("Products Filtered by Matter", { Matter_url: '<http://example.com/Rubber>' }, 8);
    variablesTest("Product Disassembly", { ProductLabel: '"Shaped shoe with midsole and outsole"' }, 2);
    simpleTest("Marketplace: Batches for Sale", 17);
    variablesTest("Batch Details", { BatchLabel: '"installed Nortec"' }, 32);
    simpleTest("Batch Matter Composition", 24);
    variablesTest("Batches Filtered by Matter", { Matter_url: '<http://example.com/Cellulose>' }, 2);
    simpleTest("Batch Price Offers", 0);
    variablesTest("End of Life Scenarios", { BuildingLabel: '"Quarter K4321"' }, 17);
    simpleTest("Overview of Electronics Products", 14);
    variablesTest("Chain of Custody", { ProductLabel: '"Speaker"' }, 5);
    simpleTest("End of Life Scenarios: Costs and Benefits", 17);
    simpleTest("Batches with Images", 54);
  });
});

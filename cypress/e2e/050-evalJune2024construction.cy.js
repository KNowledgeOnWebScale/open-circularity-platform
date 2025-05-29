import { users, login, logout, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Evaluation June 2024 - Construction";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css11_construction_user2;
    login(user.idp, user.email, user.password);
    openGroup(groupTitle);

    simpleTest("All accessible data", 435);
    simpleTest("Products", 4);
    variablesTest("Product components data", { ProductLabel: '"Nortec"' }, 3);
    variablesTest("Product matter composition", { ProductLabel: '"Calcium sulfate panel"' }, 2);
    simpleTest("Buildings", 1, "Quarter K4321");
    variablesTest("End of life scenarios", { BuildingLabel: '"Quarter K4321"' }, 3);
    simpleTest("Marketplace", 2);
    simpleTest("Sources in construction network", 6);
  });
});

import { users, login, logout, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Evaluation June 2024 - Electronics";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css11_electronics_user6;
    login(user.idp, user.email, user.password);
    openGroup(groupTitle);

    simpleTest("Overview", 6);
    variablesTest("Resilience of the supply chain of a product", { ProductLabel: '"Speaker"' }, 5);
    variablesTest("REACH compliance of product components", { ProductLabel: '"Speaker"' }, 5);
    variablesTest("Rare Earth content on product components", { ProductLabel: '"Speaker"' }, 5);
    variablesTest("Recycled content of product components", { ProductLabel: '"Speaker"' }, 5);
    simpleTest("All accessible data", 304);
    simpleTest("Sources in electronics network", 6);
  });
});

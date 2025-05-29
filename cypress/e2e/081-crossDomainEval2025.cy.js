import { users, login, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Cross-domain evaluation 2025";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css12_buildingowner123;
    login(user.idp, user.email, user.password);
    openGroup("Cross-domain evaluation 2025");

    simpleTest("Batch Price Offers", 8);
  });
});

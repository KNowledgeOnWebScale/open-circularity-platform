import { users, login, logout, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Evaluation June 2024 - Textile";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css11_textile_user6;
    login(user.idp, user.email, user.password);
    openGroup(groupTitle);

    simpleTest("All accessible data", 597);
    simpleTest("Product overview", 15);
    variablesTest("Product components data", { ProductLabel: '"Super Shoe"' }, 5);
    variablesTest("Product matter composition", { ProductLabel: '"Laces"' }, 2);
    variablesTest("Product disassembly", { ProductLabel: '"Super Shoe"' }, 2);
    simpleTest("Sources in textile network", 6);
  });
});

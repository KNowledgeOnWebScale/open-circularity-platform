import { users, login, logout, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Extended textile use case";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css5_info_texon;
    login(user.idp, user.email, user.password);
    openGroup(groupTitle);

    simpleTest("Products", 4);
    variablesTest("Product datasheets", { product: '<http://example.com/product/texon_uid-product1>' }, 77);
    simpleTest("Water properties", 4);
    simpleTest("Design for reuse", 16);
  });
});

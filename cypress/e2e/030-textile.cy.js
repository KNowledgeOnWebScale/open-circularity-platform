import { users, login, logout, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Textile use case";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css0_admin_ocp;
    login(user.idp, user.email, user.password);
    openGroup(groupTitle);

    simpleTest("Query Texon's components", 3);
    simpleTest("Query Texon's components and their materials", 11);
    simpleTest("What is the average recycled content (weight percentage) of Texon's components?", 1, "33.33");
    simpleTest("Query Manufacturer's products", 2);
    simpleTest("Query Manufacturer's products and their components", 6);
    simpleTest("What is the average recycled content (weight percentage) of Manufacturer's products?", 1, "53");
    variablesTest("What is the recycled content (weight percentage) of a given product?", { product: '<https://www.example.com/textile-data/product-p01>' }, 1);
  });
});

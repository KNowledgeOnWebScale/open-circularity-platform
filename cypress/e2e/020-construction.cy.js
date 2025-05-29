import { users, login, logout, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Construction use case";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css0_admin_ocp;
    login(user.idp, user.email, user.password);
    openGroup(groupTitle);

    simpleTest("Query Lindner Group's products", 5);
    simpleTest("Query Lindner Group's products details", 16);
    variablesTest("What are the materials of a given product?", { product: '<https://www.example.com/data/product-0x01>' }, 2);
    simpleTest("Which tiles are present in buildings?", 5);
    variablesTest("What are the tiles of a given building?", { building: '<https://www.example.com/data/building-B0>' }, 2);
    variablesTest("What are the tiles of a building with a given address?", { address: '"88 Fairview Street Mount Laurel, NJ 08054"' }, 3);
    simpleTest("Which services does Ragn-Sells provide?", 1, "https://www.example.com/data/Service-Sorting");
    simpleTest("Which waste streams does Ragn-Sells accept?", 4);
  });
});

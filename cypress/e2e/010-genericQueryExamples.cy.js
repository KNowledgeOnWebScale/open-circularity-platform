import { users, login, logout, openGroup, simpleTest, variablesTest } from "../support/utils";

const groupTitle = "Generic query examples";

describe(groupTitle, () => {
  it("should give expected number of results", () => {
    const user = users.css5_info_texon;
    login(user.idp, user.email, user.password);
    openGroup(groupTitle);

    simpleTest("Count", 1, "81");
    simpleTest("Triples", 50);
    simpleTest("Subjects", 28);
    simpleTest("Predicates", 7);
    simpleTest("Objects", 50);
    variablesTest("Triples with subject", { subject: '<https://www.example.com/textile-data/component-bom-b01>' }, 4);
    variablesTest("Triples with predicate", { predicate: '<http://www.w3.org/1999/02/22-rdf-syntax-ns#type>' }, 2);
    variablesTest("Triples with object", { object: '<https://www.example.com/textile-ont/component-material-assoc>' }, 11);
    variablesTest("Terms of type", { type: '<https://www.example.com/textile-ont/Component>' }, 14);
  });
});

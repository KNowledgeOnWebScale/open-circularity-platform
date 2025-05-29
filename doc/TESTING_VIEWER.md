# Testing the viewer

* [Testing the public viewer querying the online pods](#testing-the-public-viewer-querying-the-online-pods)
* [Testing the local viewer querying local pods](#testing-the-local-viewer-querying-local-pods)
* [Testing the local viewer querying the online pods](#testing-the-local-viewer-querying-the-online-pods)

The viewer can be tested *on your local machine* using [Cypress](https://docs.cypress.io/), making use of the Chrome browser installed on your local machine.

## Testing the public viewer querying the online pods

This test is useful to check whether all online resources are still working as intended.

To test the public viewer, which is always configured to query the online pods, proceed as follows:

* On your local machine, follow the instructions in the main README to build the *public Docker based setup case*.
* Make sure the same build result is deployed on the server and operational there and that all additional pod contents are added.
* On your local machine, in the project root, execute:
  * either `yarn run test:viewer` to run all tests in batch mode
  * or `yarn run test:viewer:interactive` to run all tests in interactive mode.

## Testing the local viewer querying local pods

This test is useful during offline development.

* On your local machine, follow the instructions in the main README
  * to build the *localhost setup case*;
  * to run it;
  * to add the pod contents for the additional use cases.
* On your local machine, in a separate terminal:
  * go to `../applied-in-architecture-miravi-a-linked-data-viewer/main`;
  * execute `npm run dev` to serve the viewer at `http://localhost:5173/`.
* On your local machine, back in your initial terminal and in the project root, execute:
  * either `yarn run test:viewer` to run all tests in batch mode
  * or `yarn run test:viewer:interactive` to run all tests in interactive mode.

## Testing the local viewer querying the online pods

This test is useful to test updated viewer code before putting it online, with unchanged public pods data.

* On your local machine, follow the instructions in the main README to build the *public Docker based setup case* (!).
* Make sure the same build result is deployed on the server and operational there and that all additional pod contents are added.
* On your local machine, in a separate terminal:
  * go to `../applied-in-architecture-miravi-a-linked-data-viewer/main`;
  * execute `npm run dev` to serve the viewer at `http://localhost:5173/`.
* On your local machine, back in your initial terminal and in the project root, execute (mind `localviewer` in the commands below):
  * either `yarn run test:localviewer` to run all tests in batch mode
  * or `yarn run test:localviewer:interactive` to run all tests in interactive mode.

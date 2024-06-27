# Extensions for Open Summer Of Code

## Note on webIds

In the tables below

* webId alternatives are given for all possible setups provided in the supported setup cases;
* `X` stands for a positive integer number in the range `0..9`.

## Additional actors / pods

| **actor** | **webId**                                                                                               | **email**         | **password**       |
|-----------|---------------------------------------------------------------------------------------------------------|-------------------|--------------------|
| osocX     | https://css12.onto-deside.ilabt.imec.be/osocX/profile/card#me <br/> http://localhost:3012/osocX/card#me | osocX@example.com | osocX              |

## Additional contents

The **Extended textile use case**, normally having all its contents in the **texon** pod, is transposed into every **osocX**'s pod:

| Pod:Resource          | osocX | brand | recycler | sorter |
|-----------------------|-------|-------|----------|--------|
| osocX:ceon/manuf1_1   | rwc   |       |          |        |
| osocX:ceon/manuf1_2   | rwc   | r     |          |        |
| osocX:ceon/manuf1_3   | rwc   | r     | r        | r      |

When using the viewer, the query group **Extended textile use case for osoc0** demonstrates this for actor **osoc0**.

Developer note: these contents are added using [this stuffing script](../scripts/stuff-pods/stuff-pods-osoc.sh).
Executed it after [the normal stuffing script](../scripts/stuff-pods/stuff-pods.sh)

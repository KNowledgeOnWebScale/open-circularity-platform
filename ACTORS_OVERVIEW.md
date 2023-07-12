# Overview of actors

Next overview can be created semi-automatically.

1. Execute in the repository root: `jq '{webId: .[].webId,email:.[].email,password:.[].password}' actors/*/config/css-users.json`.
2. Copy the result to https://tableconvert.com/json-to-markdown and edit it to become an array of objects.
3. Reorder the rows as you like.
4. Generate Markdown table (First row as headers, Pretty-print, Bold first row, Text Align Left).
5. Copy to Clipboard and paste below.

| **webId**                                    | **email**               | **password** |
|----------------------------------------------|-------------------------|--------------|
| https://css0/admin/profile/card#me           | admin@ocp.com           | admin123     |
| https://css1/lindner-group/profile/card#me   | info@lindner-group.com  | lindner123   |
| https://css2/building-owner/profile/card#me  | info@building-owner.com | building123  |
| https://css3/building-owner2/profile/card#me | bob@realestate.com      | bob123       |
| https://css4/ragn-sells/profile/card#me      | mikael@ragn-sells.se    | mikael123    |
| https://css-test/test/profile/card#me        | test@ocp.com            | test123      |

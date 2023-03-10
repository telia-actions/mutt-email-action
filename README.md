# Email GitHub Action
GitHub Action to send an email which uses [mutt](http://www.mutt.org/) under the hood.


## Usage

Create a workflow `.yml` file in your repositories `.github/workflows` directory. An [example workflow](#example-workflow) is available below (under the "Example workflow" section). For more information, reference the GitHub Help Documentation for [Creating a workflow file](https://help.github.com/en/articles/configuring-a-workflow#creating-a-workflow-file).

* You can specify single email address or multiple. To send an email to multiple users use `,` as a separator ([example workflow](#example-workflow));

* If you want to send an attachment, in the `with:` section provide a path to the file which you want to send.

* In `recipients` can specify file from github runner with comma separated emails

### Inputs

| Input | Description | Required | Example values |
| :---: | :---: | :---: | :---: |
| `recipients:` | Comma (`,`) separated list or file containing email addresses. | YES | name.surname@example.com |
| `subject:` | The subject of the email | YES | My subject |
| `body:` | Content of the email | YES | The main message |
| `attachment:` | File which will be sent | NO | ./path/to/attachment |
| `from:` | User who sends an email | YES | john.doe@example.com |
| `realname:` | Sender's name | YES | John Doe |
| `smtp_url:` | Email relay server | YES | smtp://example.com:25 |
| `smtp_pass:` | Email relay server password| NO | password123 |


### Simple usage

```yaml
        uses: telia-actions/mutt-email-action@v1
        with:
          recipients: name.surname@example.com
          from: ${{ secrets.EMAIL_ACTION_SENDER }}
          subject: Subject
          body: Hello, World!
          smtp_url: ${{ secrets.EMAIL_ACTION_SMTP_URL }}
          realname: ${{ secrets.EMAIL_ACTION_REALNAME }}
```

### Example workflow
Below you will find an example workflow using all available inputs.
*We highly recommend to put important data as a [secrets](https://docs.github.com/en/actions/security-guides/encrypted-secrets#creating-encrypted-secrets-for-a-repository).*

```yaml
name: Send email with attachment

on:
  workflow_dispatch:

jobs:
  email_job:
    runs-on: 'ubuntu-latest'      
    steps:
      - name: Create an attachment
        run: |
          cat << EOF > ./attachment.txt
          Example attachment content.
          EOF
      - name: Send email
        uses: telia-actions/mutt-email-action@v1
        with:
          recipients: name.surname@example.com, name2.surname2@example.com
          from: ${{ secrets.EMAIL_ACTION_SENDER }}
          subject: Some subject
          body: |
            Hello, World!
            
            Br,
            ${{ secrets.EMAIL_ACTION_REALNAME }}
          smtp_url: ${{ secrets.EMAIL_ACTION_SMTP_URL }}
          smtp_pass: ${{ secrets.EMAIL_ACTION_SMTP_PASS }}
          realname: ${{ secrets.EMAIL_ACTION_REALNAME }}
          attachment: ./attachment.txt
```

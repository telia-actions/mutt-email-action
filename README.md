# Email Composite GitHub Action
GitHub Action to send an email


## Usage

Create a workflow `.yml` file in your repositories `.github/workflows` directory. An [example workflow](#example-workflow) is available below (under the "Example workflow" section). For more information, reference the GitHub Help Documentation for [Creating a workflow file](https://help.github.com/en/articles/configuring-a-workflow#creating-a-workflow-file).



* You can specify single email address or multiple. To send an email to multiple users use ` , ` as a separator ([example workflow](#example-workflow));

* If you want to send an attachment, in the `with:` section provide a path to the file which you want to send. Keep in mind, that you should describe RUNNER'S path ([example workflow](#example-workflow));

* Action needs a secret for some inputs, so you should provide it in the workflow.



### Inputs

| Input | Description | Required | Example values |
| :---: | :---: | :---: | :---: |
| `recipients:` | An email address(-es) where  message will be sent. Multiple email addresses separator - ` , `, check [example workflow](#example-workflow)| YES | name.surname@example.com |
| `subject:` | Main topic of the email | YES | Subject |
| `body:` | Content of the email | YES | Message |
| `attachment:` | File which will be sent | NO | /path/to/file |
| `from:` | User who sends an email | YES | ${{ secrets.EMAIL_ACTION_SENDER }} |
| `realname:` | Sender's name | YES | ${{ secrets.EMAIL_ACTION_REALNAME }} |
| `smtp_url:` | Email relay server | YES | ${{ secrets.EMAIL_ACTION_SMTP_URL }} |
| `smtp_pass:` | Email relay server password| NO | ${{ secrets.EMAIL_ACTION_SMTP_PASS }} |


#### IMPORTANT

* `from:` - Default value is specified. Input **MUST** be used in your workflow, find correct value for it here: [inputs](#inputs). You can add your own value if you want to specify different sender;
* `realname:` - Default value is specified. Input **MUST** be used in your workflow, find correct value for it here: [inputs](#inputs). You can add your own value if you want to specify different sender's name;
* `smtp_url:` - Default value is specified. Input **MUST** be used in your workflow, find correct value for it here: [inputs](#inputs). You can add your own value if you want to use different email relay server;
* `smtp_pass:` - Not specified by default. Not necessary to use it in your workflow. Can be used with different value if needed to authenticate to your SMTP relay server. Check [inputs](#inputs);


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

If you want to send an email you must add "mutt-email-action" to your workflow as shown in the example below. 
In the example below, you can see that we are not using any secrets because we are making the assumption that the user is using their own SMTP mail server. *We highly recommend to put important data as a `secrets.`, read [important](#important).*

```yaml

...

jobs:
  email_job:
    # choose a runner
    runs-on: 'ubuntu-latest'      
    steps:
      # use the "mutt-email-action"
      - uses: telia-actions/mutt-email-action@v1
        with:
          recipients: name.surname@example.com, name2.surname2@example.com, ...
          from: name.surname@example.com # recommended to put as a ${{ secrets.<name_of_you_secret_1> }}
          subject: Subject
          body: Hello, World!
          smtp_url: smtp://example.com:25 # recommended to put as a ${{ secrets.<name_of_you_secret_2> }}
          smtp_pass: example_password # recommended to put as a ${{ secrets.<name_of_you_secret_3> }}
          realname: Example Name # recommended to put as a ${{ secrets.<name_of_you_secret_4> }}
          attachment: /home/runner/path/to/file

...

```





# cross-account-vpc-peering

クロスアカウントなVPC Peeringをお試しするためのサンプル

## Prerequisite

- 複数のAWSアカウント

## Usage

### tfstate用S3バケットの作成

accepterとrequesterのアカウントでそれぞれtfstate用S3バケットを作成しておく。バケット名は適宜変更。

accepter

```
aws s3 mb s3://vpc-peering-acceptervpc-peering-accepter --region ap-northeast-1
aws s3api put-bucket-versioning --bucket vpc-peering-accepter --versioning-configuration Status=Enabled
```

requester

```
aws-vault exec development -- aws s3 mb s3://vpc-peering-requester --region ap-northeast-1
aws-vault exec development -- aws s3api put-bucket-versioning --bucket vpc-peering-requester --versioning-configuration Status=Enabled
```

### accepter

こちらを先に実行

```
$ cd envs/accepter
$ terraform init
$ terraform apply
```

作成されたVPC IDを取得しておく

### requester

envs/requester/variable.tfを修正

- accepterのAWSアカウントID
- accepterのVPC ID

```
variable "accepter_account" {
  default = "XXXXXXXXXXXX"
}

variable "accepter_vpc_id" {
  default = "vpc-XXXXXXXXXXXXXXXXX"
}
```

terraform実行

```
$ cd envs/requester
$ terraform init
$ terraform apply
```

## Clean Up

VPCエンドポイント作ってるので、ほっとくと結構課金されます。

```
$ cd envs/requester
$ terraform destroy
```

```
$ cd envs/accepter
$ terraform destroy
```
## BQ Resources
resource "google_service_account" "bqowner" {
  account_id = "bqowner"
}

resource "google_bigquery_dataset" "assessment_dataset" {
  dataset_id                  = var.dataset_id
  friendly_name               = var.friendly_name
  description                 = var.dataset_description
  location                    = var.dataset_location
  default_table_expiration_ms = 3600000

  labels = {
    env = "default"
  }
}

resource "google_bigquery_dataset_access" "assessment_dataset_access" {
  dataset_id    = google_bigquery_dataset.assessment_dataset.dataset_id
  role          = "OWNER"
  user_by_email = google_service_account.bqowner.email
  depends_on    = [google_bigquery_dataset.assessment_dataset, google_service_account.bqowner]
}

/*

CREATE TABLE `hariprasad-sundaresan-0202.assessment`.beverages
(
  beverage_type STRING,
  beverage STRING,
  order_status STRING,
  quantity INTEGER,
  order_date DATE
)
PARTITION BY order_date
CLUSTER BY beverage_type
  OPTIONS (
    description = 'beverage table clustered beverage type & partition by order date');

// sample data

INSERT INTO `hariprasad-sundaresan-0202.assessment`.beverages VALUES ('BEER','STELLA','SHIPPED',10,'2023-05-15')
INSERT INTO `hariprasad-sundaresan-0202.assessment`.beverages VALUES ('RUM','MORGAN','SHIPPED',2,'2023-05-15')
INSERT INTO `hariprasad-sundaresan-0202.assessment`.beverages VALUES ('WHISKEY','JACK DANIELS','CANCELLED',5,'2023-05-16')
INSERT INTO `hariprasad-sundaresan-0202.assessment`.beverages VALUES ('BEER','BUDWEISER','PROCESSED',20,'2023-05-17')
INSERT INTO `hariprasad-sundaresan-0202.assessment`.beverages VALUES ('BEER','BECKS','PROCESSED',15,'2023-05-18')
INSERT INTO `hariprasad-sundaresan-0202.assessment`.beverages VALUES ('WHISKEY','HAIG','SHIPPED',5,'2023-05-19')
*/

resource "google_bigquery_table" "beverages" {
  dataset_id          = google_bigquery_dataset.assessment_dataset.dataset_id
  table_id            = "beverages"
  deletion_protection = false

  labels = {
    env = "default"
  }

  schema = <<EOF
    [
    {
        "name": "beverage_type",
        "type": "STRING",
        "mode": "REQUIRED",
        "description": "type of beverage"
    },
    {
        "name": "beverage",
        "type": "STRING",
        "mode": "REQUIRED",
        "description": "beverage name"
    },
    {
        "name": "order_status",
        "type": "STRING",
        "mode": "NULLABLE",
        "description": "order status"
    },
    {
        "name": "quantity",
        "type": "INTEGER",
        "mode": "REQUIRED",
        "description": "quantity of beverage ordered"
    },
    {
        "name": "order_date",
        "type": "DATE",
        "mode": "REQUIRED",
        "description": "Date of Order"
    }
    ]
    EOF


  ## REQUIREMENT 3 : QUERY OPTIMISATION

  clustering = ["beverage_type"]
  time_partitioning {
    type                     = "DAY"
    field                    = "order_date"
    require_partition_filter = true
  }
}

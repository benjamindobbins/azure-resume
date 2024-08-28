import logging
import os
from azure.data.tables import TableServiceClient, UpdateMode
import azure.functions as func
from azure.core.exceptions import ResourceNotFoundError, ResourceExistsError

app = func.FunctionApp()

@app.function_name(name="UpdateVisitCounter")
@app.route(route="updateCounter", methods=["POST","GET"]) 
def update_visit_counter(req: func.HttpRequest) -> func.HttpResponse:
    logging.info('Python HTTP trigger function processed a request.')

    # Retrieve the connection string from the environment variables
    connection_string = os.getenv('CosmosDBConnectionString')

    # Initialize TableServiceClient using the connection string
    table_service_client = TableServiceClient.from_connection_string(conn_str=connection_string)

    # Get a reference to the table 'VisitCounter'
    table_client = table_service_client.get_table_client(table_name='VisitCounter')

    # Define the partition and row key for the counter entity
    partition_key = "Website"
    row_key = "VisitCounter"

    try:
        # Attempt to retrieve the current counter entity
        entity = table_client.get_entity(partition_key=partition_key, row_key=row_key)
        current_count = entity.get("Count", 0)

        # Increment the counter
        new_count = current_count + 1

        # Update the entity with the new counter value
        entity["Count"] = new_count
        table_client.update_entity(entity, mode=UpdateMode.REPLACE)

        return func.HttpResponse(f"{new_count}", status_code=200)

    except ResourceNotFoundError:
        # If entity does not exist, create it with an initial count of 1
        entity = {
            'PartitionKey': partition_key,
            'RowKey': row_key,
            'Count': 1
        }
        table_client.create_entity(entity)
        return func.HttpResponse("Visit counter created with value 1", status_code=201)

    except Exception as e:
        logging.error(f"Error updating visit counter: {e}", exc_info=True)
        return func.HttpResponse("Failed to update visit counter", status_code=500)
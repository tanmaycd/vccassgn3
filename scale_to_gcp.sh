cloud auth activate-service-account --key-file=gcp-key.json

PROJECT_ID="gcpasgzn2"
ZONE="us-central1-a"
INSTANCE_GROUP="instance-group-assgn3"

echo "checking auto scaling status"

CURRENT_INSTANCES=$(gcloud compute instance-groups managed list-instances $INSTANCE_GROUP --zone $ZONE)

INSTANCE_COUNT=$(echo "$CURRENT_INSTANCES" | wc -l )

echo "current running instances :$INSTANCE_COUNT"

MAX_INSTANCES=5

if [ "$INSTANCE_COUNT" -lt "$MAX_INSTANCES" ]; then
    echo "Scaling up...adding a new instance to GCP"
    gcloud compute instance-groups managed resize $INSTANCE_GROUP --size=$((INSTANCE_COUNT + 1))
else
    echo "max instance reached no scaling needed."
fi

echo "auto-scaling script executed successfully."

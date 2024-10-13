
# Set environment variables
export PROJECT_ID=""
export PROJECT_NUM=''
export REGION="us-central1"
export SERVICE_NAME="deployment-ex1"
export SERVICE_ACCOUNT=""

# Set project
gcloud config set project $PROJECT_ID

# Enable APIs
gcloud services enable cloudbuild.googleapis.com
gcloud services enable run.googleapis.com
gcloud services enable containerregistry.googleapis.com
gcloud services enable storage-component.googleapis.com
gcloud services enable storage.googleapis.com

# Grant the Cloud Build Service Account role to the Compute Engine
# default service account
gcloud projects add-iam-policy-binding $PROJECT_ID \
--member=serviceAccount:${PROJECT_NUM}-compute@developer.gserviceaccount.com \
--role=roles/cloudbuild.builds.builder

# Wait and verify permissions
echo "Waiting for permissions to propagate..."
sleep 15

echo "Current project: $(gcloud config get-value project)"
echo "Current account: $(gcloud config get-value account)"

# Deploy from source automatically builds a container image from source code 
# and deploys it. Deploys the current directory. 
gcloud run deploy --source .




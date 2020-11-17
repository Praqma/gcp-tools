FROM google/cloud-sdk:alpine as gcsdk

ENV HELM_VERSION v3.4.0

RUN     apk update && apk add curl openssl \
    &&  gcloud components install kubectl -q  \
    &&  rm -fr /var/cache/apk/* \
               /google-cloud-sdk/bin/anthoscli  /google-cloud-sdk/bin/kubectl.* \
               /google-cloud-sdk/bin/bq /google-cloud-sdk/.install/.backup \
    &&  curl -s https://raw.githubusercontent.com/kubernetes/helm/master/scripts/get > get_helm.sh \
    &&  chmod +x get_helm.sh \
    &&  ./get_helm.sh --version ${HELM_VERSION}


FROM alpine as target
COPY --from=gcsdk /google-cloud-sdk   /google-cloud-sdk
COPY --from=gcsdk /usr/local/bin/     /usr/local/bin/
ENV PATH "/google-cloud-sdk/bin:$PATH"
RUN     apk update && apk add bash ca-certificates curl openssl python3 \
    &&  rm -rf /var/cache/apk/*



#####################################################################################################

# Notes:
# -----
# * Available tools: docker, gcloud, kubectl, helm + standard unix tools
# * Later possibilities: git, gnupg, libc-compat, py3-crcmod
# * Helm needs: curl, openssl
# * GCloud needs: python3


# Other notes:
# -----------
# There was no point in deleting __pycache__ from various directories,
#     as it only resulted in freeing about 10 MB space.
#
# The following does not work:
#      && echo 'export PATH=/google-cloud-sdk/bin:${PATH}' >> /etc/profile
# OR:
#      && echo 'export PATH=/google-cloud-sdk/bin:${PATH}' > /etc/profile.d/gcloud.sh
#
# So, the following is used:
# ENV  PATH "/google-cloud-sdk/bin:$PATH"
